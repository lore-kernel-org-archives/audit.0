Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501220;
	b=Xv+foUDRJXwQ8YDWreSGB2DVrwquw7GDa2MkO+1r/1xipdJ0ZuAI6s0a4Uxhv/3HU3UE
	 XOQlrdjcI5YBrMbYYpf4jsJBXFnLKReFnNnqim963rcUUzpjDzN2WQxQvjIJ2v6UM7mUV
	 eWY49fSbOstdO6VXwYsV/cZ7lxmmA8n1vRQbVZf2Mf8SVi019EA59xTroreYcTaiDf294
	 oz/zca1T7ogk7mwsbn+dZ1eSJT+GoWGJTWE2+bKRJ3CUcYjHLDviRIlX3bAJn7QuT3Mp9
	 7zW6bEIgEXp9PG3aynP+V7Q8uILjP6WBRdMk+oyetULVV1rVCkiuelTf2EnupnPMGJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mDpgDUFtsPoHVlaa7iw+opIS53wz/9BHDHRSCr8FGlg=;
	b=XI7u0MbJ691eWyCHFleIDgU/IK27D3xvY3qJwG6Pdb54aSBdf0/DFYFCwZC0TPwo+ILO
	 FhHE2kD4RT75WWwOne1O43Hc0pg6xqMPFTPKhkuQiPu7+TE5Ny5Myx4tBytVqZyxjkz2/
	 SAYoFPjenllm39mdpdV2MzUVOdIy240gZJ5mQEi0PdIhxOzEwf+btXIdSV5pXnznLeF5I
	 RbaSwwYcANrlgegPY90flnpMKvYmiBSauYRIkfgosLJ1C386sPangXQctd+0VZYcAsuCr
	 oDa/3yCkwqgBSHHqqvDvlU6fa4BJOPaVrCZkMACpLB+5n1mYgyg7e6eJsXda4lRgoaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnMXyOsm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF4606A32C
	for <audit@vger.kernel.org>; Tue, 20 Oct 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnMXyOsm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B13C1F000CA
	for <audit@vger.kernel.org>; Tue, 20 Oct 2026 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501219;
	bh=mDpgDUFtsPoHVlaa7iw+opIS53wz/9BHDHRSCr8FGlg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KnMXyOsmHtJnkVWAhH+zNTXwRzAzcFcuJjOw77o3eXz4x1KPPazE22gX0/JmlTbi9
	 sxT4E+4GR8+v6AIJ25q9hfOEwVUSSL2uimnXfN7ohTGeLAAa2z/c8XMHvhtKclKbqc
	 /S64kj8fvJUQm2PGe1PwmNrSguCgr+C5iJ4Nn5iAbTiKuTNNzXJON7/8mPcTc+1z+C
	 hQhf5o2hcqdGkOe8am9vyE0d5OqeQgNmEMc77ytuWagzWpsIKqHPZaOfr0kHWgoROH
	 BJ0c91LLjiJ1o7JG5BmJgM7Nja3ENnPGMb4N6I7FcNLH5OJAdgGsDWdeThG4DyAG19
	 nI/0gxuGYWnFQ==
Message-ID: <sashiko-outbox-178982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] audit: don't use the caller's root when it has no fs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org
In-Reply-To: <20261020125024.8550-1-ngocthang2710.1999@gmail.com>
References: <20261020125024.8550-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 13:00:18 +0000
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] audit: audit_log_d_path() logs <too_long> on -EINVAL from d_abso=
lute_path()
--

commit 414cd8bdacdc30225fedf858b3d33b72b5614c16
Author: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

audit: don't use the caller's root when it has no fs

This commit updates audit_log_d_path() to call d_absolute_path() instead of
d_path() when current->fs is NULL, preventing a NULL pointer dereference
when deferred __fput() runs from exit_task_work() after exit_fs() in
do_exit().

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 631d6d4a23cfd..1973da2eaf3f7 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2218,7 +2218,11 @@ void audit_log_d_path(struct audit_buffer *ab, con=
st char *prefix,
>  		audit_log_format(ab, "\"<no_memory>\"");
>  		return;
>  	}
> -	p =3D d_path(path, pathname, PATH_MAX+11);
> +	/* No fs after exit_fs(), so there is no root to be relative to */
> +	if (current->fs)
> +		p =3D d_path(path, pathname, PATH_MAX+11);
> +	else
> +		p =3D d_absolute_path(path, pathname, PATH_MAX+11);
>  	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
>  		/* FIXME: can we save some information here? */
>  		audit_log_format(ab, "\"<too_long>\"");

[Severity: Medium]
Can calling d_absolute_path() here cause audit_log_d_path() to falsely log
"<too_long>" instead of the file path?

Unlike d_path(), which dispatches path->dentry->d_op->d_dname(), prepends
" (deleted)" for unlinked dentries, and ignores positive return values from
prepend_path(), d_absolute_path() fails with ERR_PTR(-EINVAL) whenever
prepend_path() returns a value greater than 1:

fs/d_path.c:d_absolute_path() {
	struct path root =3D {};
	DECLARE_BUFFER(b, buf, buflen);

	prepend_char(&b, 0);
	if (unlikely(prepend_path(path, &root, &b) > 1))
		return ERR_PTR(-EINVAL);
	return extract_string(&b);
}

prepend_path() returns 2 when a mount has mnt_ns =3D=3D NULL (such as a
lazy-unmounted MNT_DETACH filesystem), an anonymous mount namespace (from
open_tree() or fsmount()), or MNT_NS_INTERNAL (such as pipefs, sockfs, or
anon_inodefs), and returns 3 when a dentry escapes its mount root.

In the do_exit() path that triggers this code, exit_nsproxy_namespaces()
runs after exit_fs() and before exit_task_work():

kernel/exit.c:do_exit() {
	...
	exit_files(tsk);
	exit_fs(tsk);
	exit_nsproxy_namespaces(tsk);
	exit_task_work(tsk);
	...
}

If the exiting task holds the last reference to its mount namespace (for
example, after unshare(CLONE_NEWNS) or clone(CLONE_NEWNS)),
exit_nsproxy_namespaces() -> put_nsproxy() -> put_mnt_ns() -> umount_tree()
runs before exit_task_work() and clears p->mnt_ns to NULL on the mounts in
that namespace:

fs/namespace.c:umount_tree() {
		...
		WRITE_ONCE(p->mnt_ns, NULL);
		if (how & UMOUNT_SYNC)
			p->mnt.mnt_flags |=3D MNT_SYNC_UMOUNT;

		if (mnt_has_parent(p)) {
			if (needs_cover(p, how))
				leave_cover(p);
			umount_mnt(p);
		}
		...
}

When exit_task_work() subsequently runs deferred ____fput() and reaches
audit_log_d_path(), d_absolute_path() will see mnt_ns =3D=3D NULL and return
ERR_PTR(-EINVAL), which the IS_ERR(p) check in audit_log_d_path() then
reports as "<too_long>".

Would it make more sense to use a helper that preserves d_path() semantics
(including d_dname(), " (deleted)", and detached mounts) with an empty root
path when current->fs is NULL, rather than d_absolute_path()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020125024.8550=
-1-ngocthang2710.1999@gmail.com?part=3D1
